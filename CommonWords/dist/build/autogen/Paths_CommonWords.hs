module Paths_CommonWords (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/briamann/Haskell/CommonWords/.cabal-sandbox/bin"
libdir     = "/Users/briamann/Haskell/CommonWords/.cabal-sandbox/lib/x86_64-osx-ghc-7.8.4/CommonWords-0.1.0.0"
datadir    = "/Users/briamann/Haskell/CommonWords/.cabal-sandbox/share/x86_64-osx-ghc-7.8.4/CommonWords-0.1.0.0"
libexecdir = "/Users/briamann/Haskell/CommonWords/.cabal-sandbox/libexec"
sysconfdir = "/Users/briamann/Haskell/CommonWords/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "CommonWords_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "CommonWords_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "CommonWords_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "CommonWords_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "CommonWords_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
