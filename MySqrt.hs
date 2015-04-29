module MySqrt (mySqrt, runTests) where

import Control.Applicative

mySqrt :: Double -> Maybe Double
mySqrt x
	| x < 0 = Nothing
	| x == 0 = Just 0
	| otherwise = Just (until (check x) (update x) y)
	where y = (x / 2)

testSqrt :: Double -> Maybe Double
testSqrt x = (*) <$> (mySqrt x) <*> (mySqrt x)

runTests :: IO()
runTests = do
	print "sqrt 0 ="
	print . show $ mySqrt 0
	print "sqrt -3 ="
	print . show $ mySqrt (-3)
	print "sqrt 2 squared ="
	print . show $ testSqrt 2
	print "sqrt 4 squared =" 
	print . show $ testSqrt 4

check :: Double -> Double -> Bool
check x y = abs ((x/y)-y) < 0.0001

update :: Double -> Double -> Double 
update x y = y - ((abs (y - x/y))/2 * (y - (x/y))) 

{- sqrt x = y such that y*y = x, or x/y - y = 0. So need to find y with |x/y - y| < e for some small e
 - start with e = 0.0001 and y = x/2. Keep in mind that y - x/y is the derivative of y^2/2 - x ln y
 - which is convex for positive y, so it has a global minimum. So we use gradient descent to find
 - where y - x/y is close to 0
-}

