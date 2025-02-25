//
//  bingocreator.cpp
//  MidsomerBingo::bingo-creator
//
//  Created by Groot on 2/19/25.
//

#include "include/bingocreator.hpp"

#include <fstream>

#define TOOL_VERSION (uint16_t)0x1
#define MAGIC (uint64_t)0x62696E676F

bool BingoCreator::exportFile(std::string path) const {
  std::ofstream output(path, std::ios::binary);
  if (!output) return false;

  uint64_t magic = MAGIC;
  output.write(reinterpret_cast<char *>(&magic), sizeof(uint64_t));

  uint16_t version = TOOL_VERSION;
  output.write(reinterpret_cast<char *>(&version), sizeof(uint16_t));

  uint64_t count = items.size();
  output.write(reinterpret_cast<char *>(&count), sizeof(uint64_t));

  for (auto& item : items) {
    output.write(reinterpret_cast<const char *>(&item.size), sizeof(uint64_t));
    output.write(item.item.data(), item.size);
  }

  return true;
}

bool BingoCreator::exportHTML(std::string path) const {
    std::ofstream output(path);
    if (!output) return false;

    output << "<!DOCTYPE hmtl>\n";
    output << "<html lang=en>\n";
    output << "<head>\n";
    output << "\t<meta charset=\"UTF-8\">\n";
    output << "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n";
    output << "\t<title>Barnaby Bingo</title>\n";
    output << "</head>\n";
    output << "<body>\n";
    output << "\t<ul>\n";

    for (const auto& item : items)
        output << "\t\t<li>" << item.item << "</li>\n";

    output << "\t</ul>\n";
    output << "</body>\n";
    output << "</html>";

    return true;
}

bool BingoCreator::fromText(std::string path) {
  std::ifstream input(path);
  if (!input) return false;

  std::string line;
  while (std::getline(input, line)) {
    if (line == "") continue;
    items.emplace_back(BingoItem{
      .size = line.size(),
      .item = line
    });
  }

  return true;
}
