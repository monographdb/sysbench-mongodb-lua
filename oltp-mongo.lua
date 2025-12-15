-- Copyright (C) 2006-2017 Alexey Kopytov <akopytov@gmail.com>

-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

-- -----------------------------------------------------------------------------
-- Common code for OLTP benchmarks.
-- -----------------------------------------------------------------------------
--
-- Support for MonogoDB 
-- Copyright (C) 2017 Alexey Stroganov@Percona <alexey.stroganov@percona.com>
--



function mongodb_init()

   mongorover = require("mongorover")
   mongodb_client = mongorover.MongoClient.new("mongodb://" .. sysbench.opt.mongodb_host .. 
                                               ":" .. sysbench.opt.mongodb_port.."/?serverSelectionTryOnce=false")
   mongodb_database = mongodb_client:getDatabase(sysbench.opt.mongodb_db)

   conn={}
   for t = 1, sysbench.opt.tables do
      conn[t] = mongodb_database:getCollection("sbtest" .. t)
   end
end


function init()
   assert(event ~= nil,
          "this script is meant to be included by other OLTP scripts and " ..
             "should not be called directly.")

end

if sysbench.cmdline.command == nil then
   error("Command is required. Supported commands: prepare, prewarm, run, " ..
            "cleanup, help")
end

-- Command line options
sysbench.cmdline.options = {
   mongodb_db =
      {"MongoDB: database name", "sbtest_test"},
   mongodb_host =
      {"MongoDB: hostname", "localhost"},
   mongodb_port =
      {"MongoDB: port", "27017"},
   table_size =
      {"Number of rows per table", 10000},
   read_only =
      {"Read only workload", false},
   range_size =
      {"Range size for range SELECT queries", 100},
   tables =
      {"Number of tables", 1},
   point_selects =
      {"Number of point SELECT queries per transaction", 10},
   simple_ranges =
      {"Number of simple range SELECT queries per transaction", 1},
   sum_ranges =
      {"Number of SELECT SUM() queries per transaction", 1},
   order_ranges =
      {"Number of SELECT ORDER BY queries per transaction", 1},
   distinct_ranges =
      {"Number of SELECT DISTINCT queries per transaction", 1},
   index_updates =
      {"Number of UPDATE index queries per transaction", 1},
   non_index_updates =
      {"Number of UPDATE non-index queries per transaction", 1},
   delete_inserts =
      {"Number of DELETE/INSERT combination per transaction", 1},
   range_selects =
      {"Enable/disable all range SELECT queries", true},
   auto_inc =
   {"Use AUTO_INCREMENT column as Primary Key (for MySQL), " ..
       "or its alternatives in other DBMS. When disabled, use " ..
       "client-generated IDs", true},
   skip_trx =
      {"Don't start explicit transactions and execute all queries " ..
          "in the AUTOCOMMIT mode", false},
   secondary =
      {"Use a secondary index in place of the PRIMARY KEY", false},
   create_secondary =
      {"Create a secondary index in addition to the PRIMARY KEY", true}
}


-- Template strings of random digits with 11-digit groups separated by dashes
   
-- 10 groups, 119 characters
-- local c_value_template = "###########-###########-###########-" ..
-- "###########-###########-###########-" ..
-- "###########-###########-###########-" ..
-- "###########"
local c_value_template = "###########-###########-###########"

-- 5 groups, 59 characters
-- local pad_value_template = "###########-###########-###########-" ..
--    "###########-###########"

local pad_value_template = "###########-###########-###########-" ..
   "###########-###########-###########-" ..
   "###########-###########"

function get_c_value()
   return sysbench.rand.string(c_value_template)
end

function get_pad_value()
   return sysbench.rand.string(pad_value_template)
end

function create_table(table_num)
   local id_index_def, id_def
   local engine_def = ""
   local extra_table_options = ""
   local query

   if sysbench.opt.secondary then
     id_index_def = "KEY xid"
   else
     id_index_def = "PRIMARY KEY"
   end

   print(string.format("Creating table 'sbtest%d'...", table_num))

   print(string.format("Inserting %d records into 'sbtest%d'", sysbench.opt.table_size, table_num))

   local c_val
   local pad_val
      
   for i = 1, sysbench.opt.table_size do
      
      k0_val = sb_rand(1, sysbench.opt.table_size)
      k1_val = sb_rand(1, sysbench.opt.table_size)
      k2_val = sb_rand(1, sysbench.opt.table_size)
      k3_val = sb_rand(1, sysbench.opt.table_size)
      k4_val = sb_rand(1, sysbench.opt.table_size)
      k5_val = sb_rand(1, sysbench.opt.table_size)
      k6_val = sb_rand(1, sysbench.opt.table_size)
      k7_val = sb_rand(1, sysbench.opt.table_size)
      k8_val = sb_rand(1, sysbench.opt.table_size)
      k9_val = sb_rand(1, sysbench.opt.table_size)
      c0_val = get_c_value()
      c1_val = get_c_value()
      c2_val = get_c_value()
      c3_val = get_c_value()
      c4_val = get_c_value()
      c5_val = get_c_value()
      c6_val = get_c_value()
      c7_val = get_c_value()
      c8_val = get_c_value()
      c9_val = get_c_value()
      c10_val = get_c_value()
      c11_val = get_c_value()
      c12_val = get_c_value()
      c13_val = get_c_value()
      c14_val = get_c_value()
      c15_val = get_c_value()
      c16_val = get_c_value()
      c17_val = get_c_value()
      c18_val = get_c_value()
      c19_val = get_c_value()
      c20_val = get_c_value()
      c21_val = get_c_value()
      c22_val = get_c_value()
      c23_val = get_c_value()
      c24_val = get_c_value()
      c25_val = get_c_value()
      pad0_val = get_pad_value()
      pad1_val = get_pad_value()
      pad2_val = get_pad_value()
      pad3_val = get_pad_value()
      pad4_val = get_pad_value()
      pad5_val = get_pad_value()
      pad6_val = get_pad_value()
      pad7_val = get_pad_value()
      pad8_val = get_pad_value()
      pad9_val = get_pad_value()
      pad10_val = get_pad_value()
      pad11_val = get_pad_value()
      pad12_val = get_pad_value()
      pad13_val = get_pad_value()
      pad14_val = get_pad_value()
      pad15_val = get_pad_value()
      pad16_val = get_pad_value()
      pad17_val = get_pad_value()
      pad18_val = get_pad_value()
      pad19_val = get_pad_value()
      pad20_val = get_pad_value()
      pad21_val = get_pad_value()
      pad22_val = get_pad_value()
      pad23_val = get_pad_value()
      pad24_val = get_pad_value()
      pad25_val = get_pad_value()
      pad26_val = get_pad_value()
      pad27_val = get_pad_value()
      pad28_val = get_pad_value()
      pad29_val = get_pad_value()
      pad30_val = get_pad_value()
      pad31_val = get_pad_value()
      pad32_val = get_pad_value()
      pad33_val = get_pad_value()
      pad34_val = get_pad_value()
      pad35_val = get_pad_value()
      pad36_val = get_pad_value()
      pad37_val = get_pad_value()
      pad38_val = get_pad_value()
      pad39_val = get_pad_value()
      pad40_val = get_pad_value()
      pad41_val = get_pad_value()
      pad42_val = get_pad_value()
      pad43_val = get_pad_value()
      pad44_val = get_pad_value()
      pad45_val = get_pad_value()
      pad46_val = get_pad_value()
      pad47_val = get_pad_value()
      pad48_val = get_pad_value()
      pad49_val = get_pad_value()
      pad50_val = get_pad_value()
      pad51_val = get_pad_value()
      pad52_val = get_pad_value()
      pad53_val = get_pad_value()
      pad54_val = get_pad_value()
      pad55_val = get_pad_value()
      pad56_val = get_pad_value()
      pad57_val = get_pad_value()
      pad58_val = get_pad_value()
      pad59_val = get_pad_value()
      pad60_val = get_pad_value()
      pad61_val = get_pad_value()
      pad62_val = get_pad_value()
      pad63_val = get_pad_value()
      pad64_val = get_pad_value()
      pad65_val = get_pad_value()
      pad66_val = get_pad_value()
      pad67_val = get_pad_value()
      pad68_val = get_pad_value()
      pad69_val = get_pad_value()
      pad70_val = get_pad_value()
      pad71_val = get_pad_value()
      pad72_val = get_pad_value()
      pad73_val = get_pad_value()
      pad74_val = get_pad_value()
      pad75_val = get_pad_value()
      pad76_val = get_pad_value()
      pad77_val = get_pad_value()
      pad78_val = get_pad_value()
      pad79_val = get_pad_value()
      pad80_val = get_pad_value()
      pad81_val = get_pad_value()
      pad82_val = get_pad_value()
      pad83_val = get_pad_value()
      pad84_val = get_pad_value()
      pad85_val = get_pad_value()
      pad86_val = get_pad_value()
      pad87_val = get_pad_value()
      pad88_val = get_pad_value()
      pad89_val = get_pad_value()
      pad90_val = get_pad_value()
      pad91_val = get_pad_value()
      pad92_val = get_pad_value()
      pad93_val = get_pad_value()
      pad94_val = get_pad_value()
      pad95_val = get_pad_value()
      pad96_val = get_pad_value()
      pad97_val = get_pad_value()
      pad98_val = get_pad_value()
      pad99_val = get_pad_value()


      
      -- row = { _id = i, k = k_val,
      --    k1 = k1_val, k2 = k2_val,
      --    k3 = k3_val, k4 = k4_val,
      --    k5 = k5_val, k6 = k6_val,
      --    k7 = k7_val, k8 = k8_val,
      --    k9 = k9_val,
      --    c = c_val, pad = pad_val
      -- }
      --print ( "i: ",i,"k: ",k_val,"c: ",c_val,"pad: ",pad_val)
      row = { _id = i, 
         k0 = k0_val, k1 = k1_val, k2 = k2_val,
         k3 = k3_val, k4 = k4_val, k5 = k5_val,
         k6 = k6_val, k7 = k7_val, k8 = k8_val,
         k9 = k9_val,
         c0 = c0_val, c1 = c1_val, c2 = c2_val,
         c3 = c3_val, c4 = c4_val, c5 = c5_val,
         c6 = c6_val, c7 = c7_val, c8 = c8_val,
         c9 = c9_val, c10 = c10_val, c11 = c11_val,
         c12 = c12_val, c13 = c13_val, c14 = c14_val,
         c15 = c15_val, c16 = c16_val, c17 = c17_val,
         c18 = c18_val, c19 = c19_val, c20 = c20_val,
         c21 = c21_val, c22 = c22_val, c23 = c23_val,
         c24 = c24_val, c25 = c25_val,
         pad0 = pad0_val, pad1 = pad1_val,
         pad2 = pad2_val, pad3 = pad3_val,
         pad4 = pad4_val, pad5 = pad5_val,
         pad6 = pad6_val, pad7 = pad7_val,
         pad8 = pad8_val, pad9 = pad9_val,
         pad10 = pad10_val, pad11 = pad11_val,
         pad12 = pad12_val, pad13 = pad13_val,
         pad14 = pad14_val, pad15 = pad15_val,
         pad16 = pad16_val, pad17 = pad17_val,
         pad18 = pad18_val, pad19 = pad19_val,
         pad20 = pad20_val, pad21 = pad21_val,
         pad22 = pad22_val, pad23 = pad23_val,
         pad24 = pad24_val, pad25 = pad25_val,
         pad26 = pad26_val, pad27 = pad27_val,
         pad28 = pad28_val, pad29 = pad29_val,
         pad30 = pad30_val, pad31 = pad31_val,
         pad32 = pad32_val, pad33 = pad33_val,
         pad34 = pad34_val, pad35 = pad35_val,
         pad36 = pad36_val, pad37 = pad37_val,
         pad38 = pad38_val, pad39 = pad39_val,
         pad40 = pad40_val, pad41 = pad41_val,
         pad42 = pad42_val, pad43 = pad43_val,
         pad44 = pad44_val, pad45 = pad45_val,
         pad46 = pad46_val, pad47 = pad47_val,
         pad48 = pad48_val, pad49 = pad49_val,
         pad50 = pad50_val, pad51 = pad51_val,
         pad52 = pad52_val, pad53 = pad53_val,
         pad54 = pad54_val, pad55 = pad55_val,
         pad56 = pad56_val, pad57 = pad57_val,
         pad58 = pad58_val, pad59 = pad59_val,
         pad60 = pad60_val, pad61 = pad61_val,
         pad62 = pad62_val, pad63 = pad63_val,
         pad64 = pad64_val, pad65 = pad65_val,
         pad66 = pad66_val, pad67 = pad67_val,
         pad68 = pad68_val, pad69 = pad69_val,
         pad70 = pad70_val, pad71 = pad71_val,
         pad72 = pad72_val, pad73 = pad73_val,
         pad74 = pad74_val, pad75 = pad75_val,
         pad76 = pad76_val, pad77 = pad77_val,
         pad78 = pad78_val, pad79 = pad79_val,
         pad80 = pad80_val, pad81 = pad81_val,
         pad82 = pad82_val, pad83 = pad83_val,
         pad84 = pad84_val, pad85 = pad85_val,
         pad86 = pad86_val, pad87 = pad87_val,
         pad88 = pad88_val, pad89 = pad89_val,
         pad90 = pad90_val, pad91 = pad91_val,
         pad92 = pad92_val, pad93 = pad93_val,
         pad94 = pad94_val, pad95 = pad95_val,
         pad96 = pad96_val, pad97 = pad97_val,
         pad98 = pad98_val, pad99 = pad99_val
      }
      result = conn[table_num]:insert_one(row)
      --print (result)
   end      

   if sysbench.opt.create_secondary then
      print(string.format("Creating a secondary index on 'sbtest%d'...",
                          table_num))

      -- mongodb_database:command("createIndexes", "sbtest"..table_num , { indexes = {
      --    { key = { k = 1}, name = "k"},
      --    { key = { k1 = 1}, name = "k1"},
      --    { key = { k2 = 1}, name = "k2"},
      --    { key = { k3 = 1}, name = "k3"},
      --    { key = { k4 = 1}, name = "k4"},
      --    { key = { k5 = 1}, name = "k5"},
      --    { key = { k6 = 1}, name = "k6"},
      --    { key = { k7 = 1}, name = "k7"},
      --    { key = { k8 = 1}, name = "k8"},
      --    { key = { k9 = 1}, name = "k9"}
      -- }})
      mongodb_database:command("createIndexes", "sbtest"..table_num , { indexes = {
         { key = { k0 = 1}, name = "k0"},
         { key = { k1 = 1}, name = "k1"},
         { key = { k2 = 1}, name = "k2"},
         { key = { k3 = 1}, name = "k3"},
         { key = { k4 = 1}, name = "k4"},
         { key = { k5 = 1}, name = "k5"},
         { key = { k6 = 1}, name = "k6"},
         { key = { k7 = 1}, name = "k7"},
         { key = { k8 = 1}, name = "k8"},
         { key = { k9 = 1}, name = "k9"},
         { key = { c0 = 1}, name = "c0"},
         { key = { c1 = 1}, name = "c1"},
         { key = { c2 = 1}, name = "c2"},
         { key = { c3 = 1}, name = "c3"},
         { key = { c4 = 1}, name = "c4"},
         { key = { c5 = 1}, name = "c5"},
         { key = { c6 = 1}, name = "c6"},
         { key = { c7 = 1}, name = "c7"},
         { key = { c8 = 1}, name = "c8"},
         { key = { c9 = 1}, name = "c9"},
         { key = { c10 = 1}, name = "c10"},
         { key = { c11 = 1}, name = "c11"},
         { key = { c12 = 1}, name = "c12"},
         { key = { c13 = 1}, name = "c13"},
         { key = { c14 = 1}, name = "c14"},
         { key = { c15 = 1}, name = "c15"},
         { key = { c16 = 1}, name = "c16"},
         { key = { c17 = 1}, name = "c17"},
         { key = { c18 = 1}, name = "c18"},
         { key = { c19 = 1}, name = "c19"},
         { key = { c20 = 1}, name = "c20"},
         { key = { c21 = 1}, name = "c21"},
         { key = { c22 = 1}, name = "c22"},
         { key = { c23 = 1}, name = "c23"},
         { key = { c24 = 1}, name = "c24"},
         { key = { c25 = 1}, name = "c25"}
      }})
   end
end

-- Prepare the dataset. This command supports parallel execution, i.e. will
-- benefit from executing with --threads > 1 as long as --tables > 1
function cmd_prepare()

   mongodb_init()
   for i = sysbench.tid % sysbench.opt.threads + 1, sysbench.opt.tables,  sysbench.opt.threads do
     create_table(i)
   end
end

function cmd_cleanup()

   mongodb_init()
   for i = 1, sysbench.opt.tables do
      print(string.format("Dropping table 'sbtest%d'...", i))
      conn[i]:drop()
   end
end

sysbench.cmdline.commands = {
   prepare = {cmd_prepare, sysbench.cmdline.PARALLEL_COMMAND},
   warmup = {cmd_warmup, sysbench.cmdline.PARALLEL_COMMAND},
   prewarm = {cmd_warmup, sysbench.cmdline.PARALLEL_COMMAND},
   cleanup = {cmd_cleanup}
}


local function get_table_num()
   return sysbench.rand.uniform(1, sysbench.opt.tables)
end

local function get_id()
   return sysbench.rand.default(1, sysbench.opt.table_size)
end

function begin()
end

function commit()
end


function fetch_results(result_set)
  local result 
  for result in result_set do
  end
end


function execute_point_selects()
   local tnum = get_table_num()
   local i

   for i = 1, sysbench.opt.point_selects do
      local result
      local id = get_id()
      result=conn[tnum]:find_one({_id = id}, {c = 1, _id = 0})
   end
end

function execute_simple_ranges()
   local tnum = get_table_num()

   for i = 1, sysbench.opt["simple_ranges"] do
      local results
      local id = get_id()
      local id_max = id+sysbench.opt.range_size - 1
      
      results=conn[tnum]:find({_id = { ["$gte"] = id, ["$lte"] = id_max }}, { c = 1, _id = 0 })
      fetch_results(results)      
   end
end

function execute_sum_ranges()

   local tnum = get_table_num()

   for i = 1, sysbench.opt["sum_ranges"] do
      local results
      local id = get_id()
      local id_max = id+sysbench.opt.range_size - 1
    
      
      local aggregationPipeline ={ { ["$match"] = { _id = { ["$gte"] = id, ["$lte"] = id_max }}}, 
                                   { ["$group"] = { _id = BSONNull.new(), total = { ["$sum"] = "$k" }}},
                                   { ["$project"] = { _id = 0, total = 1 }} }

      results=conn[tnum]:aggregate(aggregationPipeline)
      fetch_results(results)
   end
end


function execute_order_ranges()
   local tnum = get_table_num()

   for i = 1, sysbench.opt["order_ranges"] do
      local results
      local id = get_id()
      local id_max = id+sysbench.opt.range_size - 1
      
      local aggregationPipeline ={ { ["$match"] = { _id = { ["$gte"] = id, ["$lte"] = id_max }}}, 
                                   { ["$sort"] = { c = 1 }},
                                   { ["$project"] = { _id = 0, c = 1 }} }

      results=conn[tnum]:aggregate(aggregationPipeline)
      fetch_results(results)
   end
end

function execute_distinct_ranges()

   local tnum = get_table_num()

   for i = 1, sysbench.opt["distinct_ranges"] do
      local results
      local id = get_id()
      local id_max = id+sysbench.opt.range_size - 1
      
      local aggregationPipeline = { { ["$match"] = { _id = { ["$gte"] = id, ["$lte"] = id_max }}}, 
                                    { ["$group"] = { _id = "$c" } }, 
                                    { ["$sort"]  = { _id = -1 } } } 
                              
      results=conn[tnum]:aggregate(aggregationPipeline)
      fetch_results(results)
   end
end

function execute_index_updates()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.index_updates do
      local id=get_id()
      
      local result = conn[tnum]:update_one({_id = id },
         {["$inc"] = { k0 = 1, k1 = 1, k2 = 1, k3 = 1, k4 = 1,
                       k5 = 1, k6 = 1, k7 = 1, k8 = 1, k9 = 1},
          ["$set"] = { c0 = get_c_value(), c1 = get_c_value(),
                       c2 = get_c_value(), c3 = get_c_value(),
                       c4 = get_c_value(), c5 = get_c_value(),
                       c6 = get_c_value(), c7 = get_c_value(),
                       c8 = get_c_value(), c9 = get_c_value() }})
   end
end

function execute_non_index_updates()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.non_index_updates do
      local result
      local id=get_id()
      local c_val=get_c_value()
            
      result = conn[tnum]:update_one({_id = id }, {["$set"] = {c = c_val }})

   end
end

function execute_delete_inserts()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.delete_inserts do
      local result
      local id = get_id()
      local k = get_id()
      local c_val=get_c_value()
      local pad_val=get_pad_value()

      result = conn[tnum]:delete_one({_id = id})      

      while not pcall(function () mongodb_database:command("findAndModify", "sbtest" .. tnum  ,
                                             { query = { _id= id }, 
                                               update = { ["$set"] = { k = k, c=c_val, pad=pad_val} }, 
                                               upsert="true" }) end ) do
      end
   end
end


function thread_init(thread_id)
   mongodb_init()
end

function event()

   if not sysbench.opt.skip_trx then
      begin()
   end

   execute_point_selects()
   execute_simple_ranges()
   execute_sum_ranges()
   execute_order_ranges()
   execute_distinct_ranges()

   if not sysbench.opt.read_only then 
      execute_index_updates()
      execute_non_index_updates()
      execute_delete_inserts()
   end

   if not sysbench.opt.skip_trx then
      commit()
   end
end
