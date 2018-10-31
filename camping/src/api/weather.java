package api;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class weather {

	public List weatherAddr(String addr1, String addr2) {
		StringTokenizer st = new StringTokenizer(addr1);
		List list = new ArrayList();
		while (st.hasMoreTokens()) {
			list.add(st.nextToken());
		}

		/*for (int i = 0; i < 3; i++) {
			System.out.println(list.get(i).toString());
		}*/

		/*
		 * if (addr2 != null) { StringTokenizer st1 = new StringTokenizer(addr2); List
		 * list2 = new ArrayList(); while (st.hasMoreTokens()) {
		 * list2.add(st.nextToken()); } for(int i=0;i<3;i++) {
		 * System.out.println(list2.get(i).toString()); } return list2; } else {
		 */
		return list;
		// }
	}

	
}
