# Number Guess Game

## Overview

This is a simple terminal-based game where players attempt to guess a secret number between 1 and 1000. Players can track their progress, including the number of games played and their best performance (fewest guesses). The game data is stored in a PostgreSQL database, allowing users to store their scores and track their history.

## Features

- **Play the game**: Guess the secret number and see how many attempts it takes.
- **Track progress**: View the number of games you've played and your best score (fewest guesses).
- **Database storage**: User data (username, number of games played, best score) and game results (number of guesses per game) are stored in a PostgreSQL database.

## Requirements

- **PostgreSQL**: The game uses a PostgreSQL database to store user and game data.
- **Bash Shell**: The game script is written in Bash.

## Setup

### 1. Install PostgreSQL

Make sure you have PostgreSQL installed on your machine. You can install it from the official PostgreSQL website: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)

### 2. Clone the repository

Clone the repository containing the game script:

```bash
git clone <repository_url>
cd <game_directory>
```

### 3. Setup

Add permission to run the game script.

```bash
chmod +x number_guess.sh
```

### 4. Start the Game

To start the game, run the following command:

```bash
./number_guess.sh
```

You will be prompted to enter a username. If you're a new user, it will automatically add your data to the database. If you're a returning player, it will display your previous game statistics (total games played and best game performance).

### 5. Demo Videos

Watch these demo videos to see how the game works and to understand what’s stored in the databases (`users` and `games`):

- **[Demo Video 1: Gameplay](demo_gifs/number_guessing_game_demo.gif)** - Shows how to play the Number Guess Game.
- **[Demo Video 2: Database Content](demo_gifs/psql_demo.gif)** - Displays what is stored in the `users` and `games` databases after gameplay.

## Database Structure

- **users** table:

  - `user_id`: Unique ID for each user (Primary Key).
  - `username`: User's chosen username.
  - `games_played`: The number of games the user has played.
  - `best_game`: The best score (fewest guesses) for that user.

- **games** table:
  - `game_id`: Unique ID for each game (Primary Key).
  - `user_id`: References the `user_id` from the `users` table (Foreign Key).
  - `number_of_guesses`: The number of guesses it took to guess the secret number.

## How to Play

1. Run the game script.
2. Enter your username.
3. The system will generate a secret number between 1 and 1000.
4. Try to guess the number by entering a guess. The system will tell you if the number is higher or lower.
5. Once you guess correctly, the game will show you how many attempts it took.
6. The game will update your progress in the database.

## Contributing

If you'd like to contribute to the game, feel free to fork the repository and submit a pull request with your changes.

## License

This game is open-source and available under the MIT License.
