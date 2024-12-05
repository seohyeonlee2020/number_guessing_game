#!/bin/bash

#run database setup
DB_USER=$(psql -t -c "SELECT CURRENT_USER")
echo "DB_USER is: $DB_USER"
DB_NAME="number_guess"

#check if number_guess exists as a DB (grep the result of \l)
DB_EXISTS=$(psql -t -c '\l' | grep -w 'number_guess')
#echo db exists: $DB_EXISTS
if [[ -z $DB_EXISTS ]]
then
#if it doesnt exist, create number_guess
createdb -U $DB_USER $DB_NAME
else
echo "'$DB_NAME' already exists."
fi

PSQL="psql -U $DB_USER -d $DB_NAME -t --no-align -c"
#check if each table exists (users and games)
echo "Checking if required tables exist..."
USERS_TABLE_EXISTS=$($PSQL "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'users') AS users_exists")

if [[ $USERS_TABLE_EXISTS == 'f' ]]
then
#if not, create table
echo create Users
CREATE_USERS_TABLE=$($PSQL "CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    username character VARCHAR(50) NOT NULL,
    games_played integer NOT NULL,
    best_game integer
);")
else
echo 'number_guess.users already exists'
fi
#check if games exists
GAMES_TABLE_EXISTS=$($PSQL "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'games') AS games_exists")
if [[ $GAMES_TABLE_EXISTS == 'f' ]]
then
echo create Games
CREATE_GAMES_TABLE=$($PSQL "CREATE TABLE games(
    game_id SERIAL PRIMARY KEY,
    user_id integer NOT NULL,
    number_of_guesses integer NOT NULL DEFAULT 0
);")
else
echo 'number_guess.games already exists'
fi

#check if games has a foreign key constraint on user_id referencing user_id from users
USERS_FKEY_EXISTS=$($PSQL "SELECT EXISTS (SELECT 1 FROM information_schema.table_constraints
        WHERE constraint_name='games_user_id_fkey' AND table_name='games');")
#echo fkey: $USERS_FKEY_EXISTS
if [[ $USERS_FKEY_EXISTS == 'f' ]]
then
ADD_FKEY_GAMES=$($PSQL "ALTER TABLE games ADD FOREIGN KEY(user_id) REFERENCES users(user_id)")
else
echo 'games references user_id from users'
fi
echo Database setup complete

#game script
echo Enter your username:
read USERNAME
echo username: $USERNAME
#check if username appears in users
USER_RESULT=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")
#if username is in database
if [[ ! -z $USER_RESULT ]]
then
#get data
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
GAMES_PLAYED=$($PSQL "SELECT count(*) FROM games WHERE user_id=$USER_ID")
BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID")
#print welcome
echo "Welcome back, $USERNAME!"
if [[ $GAMES_PLAYED == 0 ]]
then
echo -e "Looks like you haven't completed any games yet."
else
echo "You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
#if user is new, add to users table
else
echo "Welcome, $USERNAME! It looks like this is your first time here."
INSERT_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 1, NULL)")
fi
#save user id
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

RANDOM_NUM=$(($RANDOM%1000+1))
#echo $RANDOM_NUM
NUM_TRIES=1
echo -e "Guess the secret number between 1 and 1000:"
read GUESS
#if guess is not an integer loop until you get a valid guess
while [[ ! $GUESS =~ ^[0-9]+$ ]]
do
(( NUM_TRIES++ ))
echo -e "That's not an integer, guess again:\n"
read GUESS
done

while [[ $GUESS != $RANDOM_NUM ]]
do
(( NUM_TRIES++ ))
if [[ $GUESS -lt $RANDOM_NUM ]]
  then
  echo -e "It's higher than that, guess again:\n"
  read GUESS
  else
  echo -e "It's lower than that, guess again:\n"
  read GUESS
fi
done
  echo -e "\nYou guessed it in $NUM_TRIES tries. The secret number was $RANDOM_NUM. Nice job!"

#add game results to database
#echo "USER_ID: $USER_ID, NUM_TRIES: $NUM_TRIES"
GAME_RESULT=$($PSQL "INSERT INTO games(user_id, number_of_guesses) VALUES($USER_ID, $NUM_TRIES)")
echo game records updated!
#echo games: $($PSQL "SELECT * FROM games")

(( GAMES_PLAYED++ ))
#update user data
UPDATE_NUM_GAMES=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED WHERE user_id=$USER_ID")
BEST_GAME=$($PSQL "select min(number_of_guesses) from games where user_id=$USER_ID")
UPDATE_BEST_GAMES=$($PSQL "UPDATE users SET best_game=$BEST_GAME WHERE user_id=$USER_ID")
echo user data updated!
