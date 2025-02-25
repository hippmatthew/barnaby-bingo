//
//  bingocreator.hpp
//  MidsomerBingo::bingo-creator
//
//  Created by Groot on 2/19/25.
//

#pragma once

#include <vector>
#include <string>
#include <stdint.h>

struct BingoItem {
  uint64_t size;
  std::string item;
};

class BingoCreator {
  public:
    BingoCreator() = default;
    BingoCreator(BingoCreator&) = default;
    BingoCreator(BingoCreator&&) = default;

    BingoCreator& operator = (BingoCreator&) = default;
    BingoCreator& operator = (BingoCreator&&) = default;

    ~BingoCreator() = default;

    bool exportFile(std::string) const;
    bool exportHTML(std::string) const;
    bool fromText(std::string);

  private:
    std::vector<BingoItem> items;
};
