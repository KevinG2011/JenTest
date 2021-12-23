import Foundation

enum Food: CaseIterable {
  case pasta, pizza, hamburger
}

for food in Food.allCases {
  print(food)
}
