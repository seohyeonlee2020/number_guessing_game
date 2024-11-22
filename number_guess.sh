#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=num_guess -t --no-align -c"
echo -e "Enter your username:"
read USERNAME

RANDOM_NUM=$(($RANDOM%1000+1))
#echo $RANDOM_NUM
NUM_TRIES=1

echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS

if [[ $GUESS == $RANDOM_NUM ]]
then
  echo -e "\nYou guessed it in $NUM_TRIES tries. The secret number was $RANDOM_NUM. Nice job!"
els
  (( NUM_TRIES++ ))
  if [[ $GUESS -lt $RANDOM_NUM ]]
  then
  echo -e "\nIt's higher than that, guess again:"
  read GUESS
  else
  echo -e "\nIt's lower than that, guess again:"
  read GUESS
  fi
fi
