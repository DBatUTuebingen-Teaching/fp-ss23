import Data.List
import Data.Char

let text = cycle ["stop","reading","!","Because","this","is","an","endless","text","that","-","once","in","a","loop","-","will","never","allow","you","to"]
let search = map (map toLower) ["A", "text", "loop", "!"]

length search
-- :sprint text     --0.5P
-- :sprint search   --1P

let finding =  search `intersect` text
-- :sprint finding  -- |
-- :sprint text     -- | 0.5P
-- :sprint search   -- |

length finding
-- :sprint finding  -- 0.5p
-- :sprint text     -- | 1.5P
-- :sprint search   -- |