#!/bin/bash


echo Enter your psql username:
read DB_USER
DB_NAME="number_guess"

export $DB_USER
export $DB_NAME

#check if number_guess exists as a DB (grep the result of \l)
DB_EXISTS="psql -U $DB_USER -lt | grep -w '$DB_NAME'"
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
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer
);")
else
echo 'Users already exists'
fi
#check if games exists
GAMES_TABLE_EXISTS=$($PSQL "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'games') AS games_exists")
if [[ $GAMES_TABLE_EXISTS == 'f' ]]
then
echo create Games
CREATE_GAMES_TABLE=$($PSQL "CREATE TABLE games(
    game_id SERIAL PRIMARY KEY,
    user_id integer NOT NULL,
    number_of_guesses integer NOT NULL
);")
else
echo 'Games already exists'
fi

#check if games has a foreign key constraint on user_id referencing user_id from users
USERS_FKEY_EXISTS=$($PSQL "SELECT EXISTS (SELECT 1 FROM information_schema.table_constraints
        WHERE constraint_name='games_user_id_fkey' AND table_name='games');")
echo fkey: $USERS_FKEY_EXISTS
if [[ $USERS_FKEY_EXISTS == 'f' ]]
then
ADD_FKEY_GAMES=$($PSQL "ALTER TABLE games ADD FOREIGN KEY(user_id) REFERENCES users(user_id)")
else
echo 'games references user_id from users'
fi
echo Database setup complete
