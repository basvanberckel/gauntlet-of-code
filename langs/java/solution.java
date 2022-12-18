import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		try {
			Scanner scanner = new Scanner(new File("cases/input/1"));

            int prev = Integer.parseInt(scanner.nextLine());
            int solution = 0;

			while (scanner.hasNextLine()) {
				int cur = Integer.parseInt(scanner.nextLine());
                if (cur > prev) {
                    solution++;
                }
                prev = cur;
			}

            System.out.println(solution);

			scanner.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

}