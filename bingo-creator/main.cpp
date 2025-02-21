//
//  main.cpp
//  MidsomerBingo::bingo-creator
//
//  Created by Groot on 2/19/25.
//

#include "include/bingocreator.hpp"

#include <iostream>

int main(int argc, char ** argv) {
  if (argc < 2) {
    std::cout << "must supply path to the item list .txt file\n";
    return -1;
  }

  std::string input, output;
  input = output = argv[1];

  unsigned long pos = output.find(".txt");
  if (pos == std::string::npos) {
    std::cout << "given invalid file. please supply a .txt file with a list of items to turn into bingo slots\n";
    return -1;
  }
  output.replace(pos, 6, ".bingo");

  BingoCreator creator;

  if (!creator.fromText(input)) {
    std::cout << "failed to generate item list from text file\n";
    return -1;
  }

  if (!creator.exportFile(output)) {
    std::cout << "failed to create new bingo file\n";
    return -1;
  }
}

