main :: IO()
main = do
  putStrLn "hello, world"
  putStrLn "計算する。"
  print $ 2 + 15
  print $ 49 * 100
  print $ 1892 - 1472
  print $ 5 / 2
  putStrLn "演算子の優先順位。"
  print $ (50 * 100) - 4999
  print $ 50 * 100 - 4999
  print $ 50 * (100 - 4999)
  print $ 5 * (-3)--単項マイナス演算子は常に括弧を要する
  putStrLn "論理演算"
  print $ True && False
  print $ True && True
  print $ False || True
  print $ not False
  print $ not (True && True)
  putStrLn "等価"
  print $ 5 == 5
  print $ 1 == 0
  print $ 5 /= 5
  print $ 5 /= 4
  print $ "hello" == "hello"
