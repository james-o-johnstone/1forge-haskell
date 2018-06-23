{-# LANGUAGE OverloadedStrings #-}

module Client (
    quota
    , getSymbols
    , marketIsOpen
    , convert
    , getQuotes
    ) where

import Data.List

import Data.Aeson   
import Network.HTTP.Simple

import JSONTypes

baseURL = "https://forex.1forge.com/1.0.3/"
apiKey = -- "YOUR API KEY HERE"

quota :: IO (Maybe Quota)
quota = do
    response <- fetch "quota?cache=false"
    return (getResponseBody response :: Maybe Quota)

getSymbols :: IO (Maybe [String])
getSymbols = do
    response <- fetch "symbols?cache=false"
    return (getResponseBody response :: Maybe [String])

getQuotes :: [String] -> IO (Maybe [Quotes])
getQuotes pairs = do 
    response <- fetch $ "quotes?pairs=" ++ intercalate "," pairs
    return (getResponseBody response :: Maybe [Quotes])

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

