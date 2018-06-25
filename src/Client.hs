{-# LANGUAGE OverloadedStrings #-}

module Client (
    convert
    , getQuote
    , getQuotes
    , getSymbols
    , marketIsOpen
    , quota
    ) where

import Data.List

import Data.Aeson   
import Network.HTTP.Simple

import JSONTypes

baseURL = "https://forex.1forge.com/1.0.3/"
apiKey = "YOUR API KEY HERE" -- obtain an API key from https://1forge.com/forex-data-api

quota :: IO (Maybe Quota)
quota = do
    response <- fetch "quota?cache=false"
    return (getResponseBody response :: Maybe Quota)

getSymbols :: IO (Maybe [String])
getSymbols = do
    response <- fetch "symbols?cache=false"
    return (getResponseBody response :: Maybe [String])

getQuotes :: [String] -> IO (Maybe [Quote])
getQuotes pairs = do 
    response <- fetch $ "quotes?pairs=" ++ intercalate "," pairs
    return (getResponseBody response :: Maybe [Quote])

getQuote :: String -> IO (Maybe Quote)
getQuote pairs = do 
    response <- fetch $ "quotes?pairs=" ++ pairs
    return (getSingleQuote (getResponseBody response :: Maybe [Quote]))

getSingleQuote :: Maybe [Quote] -> Maybe Quote
getSingleQuote quotes = do
    q <- quotes
    return (head q)

marketIsOpen :: IO (Maybe MarketStatus)
marketIsOpen = do
    response <- fetch "market_status?cache=false"
    return (getResponseBody response :: Maybe MarketStatus)

convert :: String -> String -> Float -> IO (Maybe Conversion)
convert currencyFrom currencyTo quantity = do
    response <- fetch ("convert?from=" ++ currencyFrom ++ "&to=" ++ currencyTo ++ "&quantity=" ++ show quantity)
    return (getResponseBody response :: Maybe Conversion)

fetch :: (FromJSON a) => String -> IO (Response a)
fetch uri = do
    request <- parseRequest (baseURL ++ uri ++ "&api_key=" ++ apiKey)
    httpJSON request

