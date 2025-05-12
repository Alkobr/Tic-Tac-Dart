import 'dart:io';

class TicTacToe {
  // Game board represented as a list of 9 elements
  List<String> board = List.filled(9, ' ');
  
  // Current player ('X' or 'O')
  String currentPlayer = 'X';

  // Display the current state of the board
  void displayBoard() {
    print('\n');
    print(' ${board[0]} | ${board[1]} | ${board[2]} ');
    print('---+---+---');
    print(' ${board[3]} | ${board[4]} | ${board[5]} ');
    print('---+---+---');
    print(' ${board[6]} | ${board[7]} | ${board[8]} ');
    print('\n');
  }

  // Check if the move is valid
  bool isValidMove(int position) {
    return position >= 0 && position < 9 && board[position] == ' ';
  }

  // Check for a winner
  bool checkWinner() {
    // Define winning combinations
    List<List<int>> winCombos = [
      // Rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonals
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winCombos) {
      if (board[combo[0]] != ' ' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        return true;
      }
    }
    return false;
  }

  // Check if the board is full (draw)
  bool isBoardFull() {
    return !board.contains(' ');
  }

  // Make a move
  void makeMove(int position) {
    board[position] = currentPlayer;
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  // Main game logic
  void play() {
    bool gameOver = false;
    String winner = '';

    while (!gameOver) {
      // Display current board
      displayBoard();

      // Prompt for move
      print('Player $currentPlayer, enter your move (1-9):');
      
      try {
        // Read input and convert to board index (0-8)
        int input = int.parse(stdin.readLineSync() ?? '') - 1;

        // Validate move
        if (isValidMove(input)) {
          makeMove(input);

          // Check for winner
          if (checkWinner()) {
            displayBoard();
            winner = currentPlayer == 'X' ? 'O' : 'X';
            print('Player $winner wins!');
            gameOver = true;
          } 
          // Check for draw
          else if (isBoardFull()) {
            displayBoard();
            print('It\'s a draw!');
            gameOver = true;
          }
        } else {
          print('Invalid move. The cell is either occupied or out of range.');
        }
      } catch (e) {
        print('Invalid input. Please enter a number between 1 and 9.');
      }
    }

    // Ask to play again
    print('Do you want to play again? (yes/no)');
    String? playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain == 'yes' || playAgain == 'y') {
      // Reset the game
      board = List.filled(9, ' ');
      currentPlayer = 'X';
      play();
    }
  }

  // Start the game
  void start() {
    print('Welcome to Tic-Tac-Toe!');
    print('Players will take turns entering a number (1-9) corresponding to the board positions:');
    print(' 1 | 2 | 3 ');
    print('---+---+---');
    print(' 4 | 5 | 6 ');
    print('---+---+---');
    print(' 7 | 8 | 9 ');
    play();
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.start();
}
