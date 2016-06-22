{-# LANGUAGE ImplicitParams #-}

module Control.Monad.Logger.Located.Internal where

import Control.Monad
import Control.Monad.Logger
import Data.Maybe
import GHC.SrcLoc
import GHC.Stack

logStack :: (?stk :: CallStack, MonadLogger m, ToLogStr msg)
         => LogSource -> LogLevel -> msg -> m ()
logStack = case getLoc of
    Nothing -> monadLoggerLog defaultLoc
    Just l  -> monadLoggerLog l

getLoc :: (?stk :: CallStack) => Maybe Loc
getLoc = extractLoc ?stk

-- TODO: find correct function in callstack instead of last location
extractLoc :: CallStack -> Maybe Loc
extractLoc = return . srcLocToLoc . snd <=< listToMaybe . reverse . getCallStack

srcLocToLoc :: SrcLoc -> Loc
srcLocToLoc sl = Loc
    { loc_filename = srcLocFile sl
    , loc_package = srcLocPackage sl
    , loc_module = srcLocModule sl
    , loc_start = (srcLocStartLine sl, srcLocStartCol sl)
    , loc_end = (srcLocEndLine sl, srcLocEndCol sl)
    }

defaultLoc :: Loc
defaultLoc = Loc "<unknown>" "<unknown>" "<unknown>" (0,0) (0,0)