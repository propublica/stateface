# http://webhelp.esri.com/arcims/9.2/general/mergedProjects/wfs_connect/wfs_admin/srs_list.htm
state_planes = {
  "AL" => "EPSG:26729",
  "AK" => "EPSG:102006",
  "AZ" => "EPSG:26748",
  "AR" => "EPSG:26751",
  "CA" => "EPSG:26741",
  "CO" => "EPSG:26753",
  "CT" => "EPSG:2234",
  "DE" => "EPSG:26757",
  "FL" => "EPSG:26758",
  "GA" => "EPSG:26766",
  "HI" => "EPSG:102007",
  "ID" => "EPSG:26768",
  "IL" => "EPSG:26771",
  "IN" => "EPSG:26773",
  "IA" => "EPSG:26775",
  "KS" => "EPSG:26777",
  "KY" => "EPSG:2798",
  "LA" => "EPSG:26781",
  "ME" => "EPSG:26783",
  "MD" => "EPSG:26785",
  "MA" => "EPSG:26786",
  "MI" => "EPSG:102120",
  "MN" => "EPSG:26791",
  "MS" => "EPSG:26794",
  "MO" => "EPSG:26796",
  "MT" => "EPSG:32001",
  "NE" => "EPSG:32005",
  "NV" => "EPSG:32007",
  "NH" => "EPSG:32110",
  "NJ" => "EPSG:32011",
  "NM" => "EPSG:32012",
  "NY" => "EPSG:32015",
  "NC" => "EPSG:2264",
  "ND" => "EPSG:102720",
  "OH" => "EPSG:32022",
  "OK" => "EPSG:32024",
  "OR" => "EPSG:2838",
  "PA" => "EPSG:32028",
  "RI" => "EPSG:32130",
  "SC" => "EPSG:102733",
  "SD" => "EPSG:102734",
  "TN" => "EPSG:32036",
  "TX" => "EPSG:32037",
  "UT" => "EPSG:32042",
  "VT" => "EPSG:32045",
  "VA" => "EPSG:32046",
  "WA" => "EPSG:2855",
  "WV" => "EPSG:32050",
  "WI" => "EPSG:2859",
  "WY" => "EPSG:32055",
  "DC" => "EPSG:3785"
}

ROOT = File.expand_path(File.dirname(File.basename(__FILE__)))

state_planes.keys.each do |k|
  command = "#{ROOT}/font-for-us -s 5 -n Postal -p '#{state_planes[k]}' -f #{k} #{ROOT}/us-states/ne_10m_admin_1_states_provinces_lakes_shp.shp"
  puts command
  `#{command}`
end

# pr
`#{ROOT}/font-for-us -s 2 -n stusps -p 'EPSG:3785' -f PR #{ROOT}/us-states/pr-no-water.shp`
