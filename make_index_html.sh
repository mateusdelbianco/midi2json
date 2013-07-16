#!/bin/bash
ruby midi2json.rb test.mid > tmp_test.json
ruby json2html.rb tmp_test.json > tmp_test.html
sed '/__LYRICS__/{
    s/__LYRICS__//g
    r tmp_test.html
}' template.html > index.html
rm -f tmp_test.json
rm -f tmp_test.html
