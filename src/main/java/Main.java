import java.util.Arrays;
import java.util.Scanner;

public class Main {
	public static void main(String args[]){
		int A;
		int B;
		int[] intArr = new int[5];
		Scanner sc = new Scanner(System.in);
		A = sc.nextInt();
		B = sc.nextInt();
		
		
		
		for(int i = 0; i < intArr.length; i++) {
			intArr[i] = sc.nextInt();
		}
		
		Arrays.sort(intArr);
		
		for(int i : intArr) {
			if(intArr[i] == intArr[i+1]) {
				continue;
				System.out.println(i);
			}
			
		}
		
		
//		if(A < B) {
//			System.out.println("23" + " "+ "25");
//		} else if ((A == 0) && (B > 45)) {
//			System.out.println(A + " "+ (B-45));
//		} else if ((A == 0) && (B <= 45)) {
//			System.out.println("23" + " "+ (B+15));
//		} else if ((A != 0) && (B >= 45)) {
//			System.out.println(A + " "+ (B-45));
//		} else {
//			System.out.println(A-1 + " " + (B+15));
//		}
	}
}
