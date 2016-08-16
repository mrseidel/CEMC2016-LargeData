/**
 *This file is for the sort and search functions
 *
 * @author F.D.
 * @since January 21st, 2015
 * @since JDK 8
 * @version 1.0
 * 
 */

/** This function takes in a string value and returns a list of the columns strings without repeat values
 *
 *  @param column  This is the string of the column to be sorted through
 *  @return        The return value is the string list of all strings without repeat values
 */
StringList noRepeatSort(String column) {
  int copy;
  StringList group = new StringList();

  for (TableRow row : table.rows()) {
    copy = 0;
    String temp = row.getString(column);

    for (String i : group) {
      if (temp.equals(i)) {
        copy++;
      }
    }

    if (copy == 0) {
      group.append(temp);
    }
  }

  return group;
}

/** This function takes in an array and organizes it in numerical order
 *
 *  @param array   This is the array to be sorted
 *  @param left  This is the first index of the array
 *  @param right  This is the last index of the array
 */
void quickSort(int array[], int left, int right) {
  int i = left, j = right;
  int temp;
  int pivot = array[(i + j) / 2];

  while (i <= j) {
    while (array[i] < pivot)
      i++;
    while (array[j] > pivot)
      j--;
    if (i <= j) {
      temp = array[i];
      array[i] = array[j];
      array[j] = temp;
      i++;
      j--;
    }
  };

  int index = i;
  if (left < index - 1)
    quickSort(array, left, index - 1);
  if (index < right)
    quickSort(array, index, right);
}

/** This function takes in two string values and returns the indices of all rows containing the string
 *
 *  @param find   This is the string to be searched for
 *  @param column  This is the string of the column to be searched in
 *  @return        The return value is the integer list of all rows containing the search query
 */
IntList columnSearch(String find, String column) {
  IntList group = new IntList();

  for (int i = 0; i < table.getRowCount(); i++) {
    if (table.getRow(i).getString(column).equals(find)) {
      group.append(i);
    }
  }

  return group;
}