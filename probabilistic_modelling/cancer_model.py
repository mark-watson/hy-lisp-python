# use Wisconsin cancer dataset

import csv
from pomegranate import *

training_csv_data = '../data/train_wisconsin.csv'
test_csv_data = '../data/test_wisconsin.csv'


def transform_data(file_path):
  """ Convert 10 columns of numeric data in CSV file to boolean
      data. Original data:
        - 0 Clump Thickness               1 - 10
        - 1 Uniformity of Cell Size       1 - 10
        - 2 Uniformity of Cell Shape      1 - 10
        - 3 Marginal Adhesion             1 - 10
        - 4 Single Epithelial Cell Size   1 - 10
        - 5 Bare Nuclei                   1 - 10
        - 6 Bland Chromatin               1 - 10
        - 7 Normal Nucleoli               1 - 10
        - 8 Mitoses                       1 - 10
        - 9 Class (0 for benign, 1 for malignant)
  """

  num_rows = 0
  sums = [0] * 9
  num_positive_samples = 0
  with open(file_path) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
      num_rows += 1
      for i in range(0, 9):
        sums[i] += int(row[i])
      num_positive_samples += int(row[9])  # 10th column is 0 or 1
  for i in range(0, 9):
    sums[i] = sums[i] / num_rows
  print(f"Average values for first 9 columns: {sums}")
  print(f"\n Number of positive samples = {num_positive_samples}")
  print(f" Number of negative samples = {num_rows - num_positive_samples}\n")
  data = []
  with open(file_path) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
      alist = []
      for i in range(0, 9):
        if int(row[i]) > sums[i]:
          alist.append('True')
        else:
          alist.append('False')
      if row[9] == '1':
        alist.append('True')
      else:
        alist.append('False')
      data.append(alist)
  return data


if __name__ == "__main__":
  training = transform_data(training_csv_data)
  cancer_predictions = DiscreteDistribution({'True': 0.33, 'False': 0.67})
  print("** cancer_predictions:", cancer_predictions)
