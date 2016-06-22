{-# LANGUAGE ImplicitParams    #-}
{-# LANGUAGE OverloadedStrings #-}

module Control.Monad.Logger.Located
    ( module Control.Monad.Logger
    , logDebug, logInfo, logWarn, logError, logOther
    , logDebugS, logInfoS, logWarnS, logErrorS, logOtherS
    ) where

import Control.Monad.Logger hiding (logDebug, logDebugN, logDebugNS, logDebugS,
                             logError, logErrorN, logErrorNS, logErrorS,
                             logInfo, logInfoN, logInfoNS, logInfoS, logOther,
                             logOtherN, logOtherNS, logOtherS, logWarn,
                             logWarnN, logWarnNS, logWarnS)
import Data.Text
import GHC.Stack

import Control.Monad.Logger.Located.Internal

logDebug :: (?stk :: CallStack, MonadLogger m) => Text -> m ()
logDebug  = logDebugS ""

logInfo :: (?stk :: CallStack, MonadLogger m) => Text -> m ()
logInfo  = logInfoS ""

logWarn :: (?stk :: CallStack, MonadLogger m) => Text -> m ()
logWarn  = logWarnS ""

logError :: (?stk :: CallStack, MonadLogger m) => Text -> m ()
logError  = logErrorS ""

logOther :: (?stk :: CallStack, MonadLogger m) => LogLevel -> Text -> m ()
logOther = logOtherS ""

logDebugS :: (?stk :: CallStack, MonadLogger m) => LogSource -> Text -> m ()
logDebugS s = logStack s LevelDebug

logInfoS :: (?stk :: CallStack, MonadLogger m) => LogSource -> Text -> m ()
logInfoS s = logStack s LevelInfo

logWarnS :: (?stk :: CallStack, MonadLogger m) => LogSource -> Text -> m ()
logWarnS s = logStack s LevelWarn

logErrorS :: (?stk :: CallStack, MonadLogger m) => LogSource -> Text -> m ()
logErrorS s = logStack s LevelError

logOtherS :: (?stk :: CallStack, MonadLogger m) => LogSource -> LogLevel -> Text -> m ()
logOtherS = logStack
