{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module JSONTypes
    ( Conversion(..)
    , MarketStatus(..)
    , Quota(..)
    , Quote(..)
    ) where

import Data.Aeson (defaultOptions, fieldLabelModifier, FromJSON (..), genericParseJSON)
import GHC.Generics (Generic)

data MarketStatus = MarketStatus
    { market_is_open :: Bool
    } deriving (Generic, Show)

instance FromJSON MarketStatus

data Quota = Quota
    { quota_used :: Int
    , quota_limit :: Int
    , quota_remaining :: Int
    , hours_until_reset :: Int
    } deriving (Generic, Show)

instance FromJSON Quota

data Quote = Quote
    { bid :: Double
    , symbol :: String
    , ask :: Double
    , price :: Double
    , timestamp :: Int
    } deriving (Generic, Show)

instance FromJSON Quote

data Conversion = Conversion
    { cvalue :: Double
    , ctext :: String
    , cTimestamp :: Int
    } deriving (Generic, Show)

instance FromJSON Conversion where
    parseJSON = genericParseJSON defaultOptions { fieldLabelModifier = drop 1 }