module Main where

import Client (marketIsOpen, getSymbols, getQuotes, convert, quota)

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