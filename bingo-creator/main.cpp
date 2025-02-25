//
//  main.cpp
//  MidsomerBingo::bingo-creator
//
//  Created by Groot on 2/19/25.
//

#include "include/bingocreator.hpp"

#include <iostream>

int main(int argc, char ** argv) {
  if (argc < 3) {
    std::cout << "must supply path to the item list .txt file and whether it is source or html output\n";
    return -1;
  }

  if (std::string(argv[2]) != "source" && std::string(argv[2]) != "html") {
    std::cout << "output type is either source or html\n";
    return -1;
  }

  bool isSource = std::string(argv[2]) == "source";

  std::string input = argv[1];
  std::string output = "list.html";

  if (isSource) {
    output = input;

    unsigned long pos = output.find(".txt");
    if (pos == std::string::npos) {
      std::cout << "given invalid file. please supply a .txt file with a list of items to turn into bingo slots\n";
      return -1;
    }

    output.replace(pos, 6, ".bingo");
  }

  BingoCreator creator;

  if (!creator.fromText(input)) {
    std::cout << "failed to generate item list from text file\n";
    return -1;
  }

  if (isSource) {
    if (!creator.exportFile(output)) {
      std::cout << "failed to create new bingo file\n";
      return -1;
    }
  }
  else {
    if (!creator.exportHTML(output)) {
      std::cout << "failed to create html file\n";
      return -1;
    }
  }
}

