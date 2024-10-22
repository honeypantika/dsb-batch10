## Designing a Rock, Paper, Scissors Game in R

# 1. Define functions for each choice
    rock_wins <- function(choice) choice == "scissors"
    paper_wins <- function(choice) choice == "rock"
    scissors_wins <- function(choice) choice == "paper"
    # -- If both players choose the same, it is a tie --

# 2. Function to determine the winner based on choices
    determine_winner <- function(user_choice, computer_choice) {
      if (user_choice == computer_choice) {
        message("It's a tie!")
        return(0) # No score for a tie
      } else if (user_choice == "rock" && computer_choice == "scissors" ||
                 user_choice == "paper" && computer_choice == "rock" ||
                 user_choice == "scissors" && computer_choice == "paper") {
        message("User wins!")
        return(1) # Score 1 for win
      } else {
        message("Computer wins!")
        return(1) # Score 1 for win
      }
    }
    
# 3. Function to play a single round
    play_round <- function() {
      user_choice <- sample(c("rock", "paper", "scissors"), 1)
      computer_choice <- sample(c("rock", "paper", "scissors"), 1)
      
      score <- determine_winner(user_choice , computer_choice)
      
      cat("user_choice :", user_choice , "\n")
      cat("computer_choice:", computer_choice, "\n")
      cat("score:", score, "\n")
    }

# 4. Play multiple rounds
    num_rounds <- 10  # Adjust the number of rounds as desired
    for (i in 1:num_rounds) {
      play_round()
    }
