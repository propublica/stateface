require 'rubygems'
require 'erb'
require 'json'
require 'rdiscount'

STATES = [
  ["Alabama", "AL", "Ala.", 1, "B"],
  ["Alaska", "AK", "Alaska", 2, "A"],
  ["Arizona", "AZ", "Ariz.", 4, "D"],
  ["Arkansas", "AR", "Ark.", 5, "C"],
  ["California", "CA", "Calif.", 6, "E"],
  ["Colorado", "CO", "Colo.", 8, "F"],
  ["Connecticut", "CT", "Conn.", 9, "G"],
  ["Delaware", "DE", "Del.", 10, "H"],
  ["District of Columbia", "DC", "D.C.", 11, "y"],
  ["Florida", "FL", "Fla.", 12, "I"],
  ["Georgia", "GA", "Ga.", 13, "J"],
  ["Hawaii", "HI", "Hawaii", 15, "K"],
  ["Idaho", "ID", "Idaho", 16, "M"],
  ["Illinois", "IL", "Ill.", 17, "N"],
  ["Indiana", "IN", "Ind.", 18, "O"],
  ["Iowa", "IA", "Iowa", 19, "L"],
  ["Kansas", "KS", "Kan.", 20, "P"],
  ["Kentucky", "KY", "Ky.", 21, "Q"],
  ["Louisiana", "LA", "La.", 22, "R"],
  ["Maine", "ME", "Maine", 23, "U"],
  ["Maryland", "MD", "Md.", 24, "T"],
  ["Massachusetts", "MA", "Mass.", 25, "S"],
  ["Michigan", "MI", "Mich.", 26, "V"],
  ["Minnesota", "MN", "Minn.", 27, "W"],
  ["Mississippi", "MS", "Miss.", 28, "Y"],
  ["Missouri", "MO", "Mo.", 29, "X"],
  ["Montana", "MT", "Mont.", 30, "Z"],
  ["Nebraska", "NE", "Neb.", 31, "c"],
  ["Nevada", "NV", "Nev.", 32, "g"],
  ["New Hampshire", "NH", "N.H.", 33, "d"],
  ["New Jersey", "NJ", "N.J.", 34, "e"],
  ["New Mexico", "NM", "N.M.", 35, "f"],
  ["New York", "NY", "N.Y.", 36, "h"],
  ["North Carolina", "NC", "N.C.", 37, "a"],
  ["North Dakota", "ND", "N.D.", 38, "b"],
  ["Ohio", "OH", "Ohio", 39, "i"],
  ["Oklahoma", "OK", "Okla.", 40, "j"],
  ["Oregon", "OR", "Ore.", 41, "k"],
  ["Pennsylvania", "PA", "Pa.", 42, "l"],
  ["Rhode Island", "RI", "R.I.", 44, "m"],
  ["South Carolina", "SC", "S.C.", 45, "n"],
  ["South Dakota", "SD", "S.D.", 46, "o"],
  ["Tennessee", "TN", "Tenn.", 47, "p"],
  ["Texas", "TX", "Texas", 48, "q"],
  ["Utah", "UT", "Utah", 49, "r"],
  ["Vermont", "VT", "Vt.", 50, "t"],
  ["Virginia", "VA", "Va.", 51, "s"],
  ["Washington", "WA", "Wash.", 53, "u"],
  ["West Virginia", "WV", "W.Va.", 54, "w"],
  ["Wisconsin", "WI", "Wis.", 55, "v"],
  ["Wyoming", "WY", "Wyo.", 56, "x"],
  ["United States", "US", "U.S.", nil, "z"]
]

state_characters = {}
STATES.each { |s| state_characters[s[1]] = s[4] }

template = %q{
<!doctype html>
<html>
  <head>
    <title>StateFace</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="reference/styles.css" type="text/css">
    <link rel="stylesheet" href="reference/stateface.css" type="text/css">
    <link rel="stylesheet" href="reference/stateface-generated.css" type="text/css">
  </head>
  <body>
  <%= RDiscount.new(File.read './reference.mdown').to_html %>
  </body>
</html>
}

table = %q{
  <div id="font-map">
    <% STATES.sort.each_slice(18) do |group| %>
      <table class="StateFace">
        <% group.each do |state| %>
          <tr>
            <td class="minimap"><%= state[4] %></td>
            <td><%= state[2] %></td>
            <td><%= state[4] %></td>
          </tr>
        <% end %>
      </table>
    <% end %>
  </div>
}

File.open('../index.html', 'w') do |f|
  f.write ERB.new(template).result(binding).gsub('<p>&lt;%= table %></p>', ERB.new(table).result)
end

File.open('stateface.json', 'w') do |f|
  f.write ERB.new(JSON.pretty_generate(state_characters)).result
end


