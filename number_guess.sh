#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "Enter your username:"
read USERNAME

#check if username appears in users
USER_RESULT=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'")
#if username is in database
if [[ ! -z $USER_RESULT ]]
then
#get data
GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
#print welcome
echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
#if not, add user
else
INSERT_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 1, 0)")
fi
#save user id
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

#generate random num
RANDOM_NUM=$(($RANDOM%1000+1))
#echo $RANDOM_NUM
NUM_TRIES=1
echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS
#if guess is not an integer loop until you get a valid guess
while [[ ! $GUESS =~ ^[0-9]+$ ]]
do
echo -e "\nThat is not an integer, guess again:"
read GUESS
done

while [[ $GUESS != $RANDOM_NUM ]]
do
(( NUM_TRIES++ ))
if [[ $GUESS -lt $RANDOM_NUM ]]
  then
  echo -e "\nIt's higher than that, guess again:"
  read GUESS
  else
  echo -e "\nIt's lower than that, guess again:"
  read GUESS
fi
done
  echo -e "\nYou guessed it in $NUM_TRIES tries. The secret number was $RANDOM_NUM. Nice job!"
#add game results to database
GAME_RESULT=$($PSQL "INSERT INTO games(user_id, number_of_guesses) VALUES($USER_ID, $NUM_TRIES)")

#update user data
UPDATE_NUM_GAMES=$($PSQL "UPDATE users SET games_played = (games_played + 1) WHERE user_id=$USER_ID")
BEST_GAME=$($PSQL "select min(number_of_guesses) from games where
user_id=1")
UPDATE_BEST_GAMES=$($PSQL "UPDATE users SET best_game=$BEST_GAME WHERE user_id=$USER_ID")