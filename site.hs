---
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
---

main = hakyll $ do
        match "site/res/*" $ do
                route $ dropPat "site/"
                compile copyFileCompiler

        match "site/*.md" $ do
                route $ composeRoutes (setExtension "html") (dropPat "site/")
                compile $ pandocCompiler
                        >>= loadAndApplyTemplate "site/templates/default.html" defaultContext

        match "site/templates/*" $ compile templateBodyCompiler

---
dropPat :: String -> Routes
dropPat pat = gsubRoute pat (const "")
