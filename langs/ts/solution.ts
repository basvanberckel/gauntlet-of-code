import * as fs from 'fs';
import * as rd from 'readline';

var reader = rd.createInterface(fs.createReadStream("cases/input/1"));

var prev = Infinity;
var solution = 0;
reader.on("line", (l: string) => {
    var cur = parseInt(l);
    if (cur > prev) solution++;
    prev = cur;
});

reader.on("close", () => console.log(solution));