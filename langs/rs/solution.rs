use std::fs::{self, File};
use std::io::{self, BufRead, BufReader, Lines};

fn solve(mut lines: Lines<BufReader<File>>) -> Result<String, io::Error> {
    let mut solution = 0;
    let mut prev = lines.next().unwrap().unwrap();
    for line in lines {
        let line = line.unwrap();
        if line > prev {
            solution += 1;
        }
        prev = line;
    }

    Ok(solution.to_string())
}


fn main() -> Result<(), io::Error> {
    for f in fs::read_dir("cases/input").unwrap() {
        let path = f?.path();
        let file = File::open(&path)?;
        let reader = BufReader::new(file);
        let lines = reader.lines();

        let solution = solve(lines)?;
        let casename = path.file_name().unwrap().to_str().unwrap();
        println!("Output for case {}:", casename);
        println!("\t{}", solution);
        let output_path = String::from("cases/output/") + casename;
        let output_file = match File::open(output_path) {
            Err(_) => continue,
            Ok(f) => f,
        };

        let output_reader = BufReader::new(output_file);
        let expected = output_reader.lines().next().unwrap().unwrap();
        if solution == expected {
            println!("pass");
            continue;
        }
        println!("Expected:");
        println!("\t{}", expected);
    }

    Ok(())
}
