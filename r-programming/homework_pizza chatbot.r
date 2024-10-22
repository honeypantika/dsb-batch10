# 0. install packages & load libraries
install.packages("tidyverse")
install.packages("glue")

library(tidyverse)
library(glue)

hello_pizza <- function() {
  
# 1. present menu to customer
  pizza_menu <- tibble(
    no = 1:10,
    menu = c("Hawaiian", "Margharita", "Pepperoni", "Super Bacon", 
             "Extreme Cheese", "Shrimp Cocktail", "Extravaganzza", 
             "Korean Beef Bulgogi", "American Hitz", "Seafood Lover"),
    price = c(99, 99, 139, 139, 279, 279, 279, 299, 299, 329)
  )
  
  appetizer_menu <- tibble(
    no = 11:15,
    menu = c("Fried Shrimp with Sriracha Mayo Sauce", 
             "Wing Spicy BBQ Sauce", "Spanich Au Gratin",
             "Bacon Spicy Spaghetti", "Seafood Island Spaghetti"),
    price = c(79, 129, 159, 99, 129)
  )
  
  drink_menu <- tibble(
    no = 16:20,
    menu = c("Drinking Water", "Root Beer", "Coca Cola", 
             "Orange", "Sprite"),
    price = c(15, 25, 25, 25, 25)
  )
  
  full_menu <- rbind(pizza_menu, appetizer_menu, drink_menu)
  
# 2. greeting 
  print("Welcome to Honey Pizzeria!")
  print("What is your name?")
  customer_name <- readline("Enter name: ")
  
# 3. ordering, print order receipt, calculate total payment
  print("We offer a variety of pizzas, appetizers, and drinks menu")
  print(full_menu)
  print("What would you like to order today?")
  print("If your order completed, please press 99")
  
  all_order <- c()
  all_quantity <- c()
  while(TRUE) {
    order <- readline("Enter no: ")
    if (order != 99) {
      all_order <- append(all_order, order)
      quantity <- readline("Enter amount of order: ")
      all_quantity <- append(all_quantity, quantity)
      print("-- add order --")
    } else {
      break
    }
  }
  order_df <- tibble(no = as.numeric(all_order), 
                     quantity = as.numeric(all_quantity))
  
  
  receipt <- full_menu %>%
    select(no, menu, price) %>%
    inner_join(order_df, by = c("no" = "no")) %>%
    mutate(total = price * quantity)
  print(receipt)
  
  
  total_payment <- receipt %>%
    summarise(order_total = sum(total))
  print(total_payment)
  
# 4. ask for payment option
  print("Would you like to pay by cash or credit card?")
  payment_option <- readline("Enter payment: ")
  
# 5. customer order 
  print(glue("This is {customer_name}'s order:"))
  print(receipt)
  print(glue("Total Payment: {total_payment} Bath"))
  print(glue("Payment Option: {payment_option}"))
  print("Thank you for your order! Have a nice day :)")
}
