module Main where

import Client
import JSONTypes

main :: IO ()
main = do
    marketOpen <- marketIsOpen
    print marketOpen

    symbols <- getSymbols
    print symbols

    quotes <- getQuotes ["BTCGBP", "BTCETH"]
    print quotes

    conversion <- convert "BTC" "GBP" 1.234
    print conversion

    remQuota <- quota
    print remQuota