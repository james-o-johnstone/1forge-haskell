{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module JSONTypes (
    Conversion(..)
    , MarketStatus(..)
    , Quota(..)
    , Quotes(..)
    ) where

import Data.Aeson
import GHC.Generics

data MarketStatus = MarketStatus { 
    market_is_open :: Bool
} deriving (Generic, Show)

instance FromJSON MarketStatus

data Quota = Quota {
    quota_used :: Int
    , quota_limit :: Int
    , quota_remaining :: Int
    , hours_until_reset :: Int
} deriving (Generic, Show)

instance FromJSON Quota

data Quotes = Quotes {
    bid :: Float
    , symbol :: String
    , ask :: Float
    , price :: Float
    , timestamp :: Int
    } deriving (Generic, Show)

instance FromJSON Quotes

data Conversion = Conversion {
    value :: Float
    , text :: String
    , cTimestamp :: Int
} deriving Show

instance FromJSON Conversion where
    parseJSON = withObject "Conversion" $ \v -> Conversion
        <$> v .: "value"
        <*> v .: "text"
        <*> v .: "timestamp"