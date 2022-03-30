import re

OUT_FILE = 'aggregate.sql'
TABLES = [
	'property',
	'person',
	'pet',
	'pay_card',
	'venmo',
	'ach',
	'apartment',
	'prop_amenity',
	'apt_amenity',
	'visited',
	'prev_addr',
	'renter_info',
	'lease',
	'pet_on_lease',
	'person_on_lease'
]


def csv_to_sql(table: str, csv_data, out_fw):
	with open(csv_data, mode='r', buffering=1) as csv:
		line = csv.readline() # Block out the header		

		out_fw.write(f"-- TABLE: {table}\n-- Schema: {line}")
		while (line := csv.readline()):
			values = line[:-1].split(',')
			for i in range(len(values)):
				value = values[i]
				if value == "":
					values[i] = "NULL"
				elif re.match(r"\d{2}/\d{2}/\d{4}", value):
					values[i] = f"to_date('{value}', 'MM/DD/YYYY')"
				elif value == 'DEFAULT':
					pass
				elif value.isnumeric() and len(value) >= 3:
					values[i] = f"'{value}'"
				elif not value.isnumeric():
					values[i] = f"'{value}'"
			reformat = ','.join(values)

			out_fw.write(
				f"insert into {table} values({reformat});\n"
			)
		out_fw.write("\n\n\n")
		
def convert():
	with open(OUT_FILE, mode='a') as out:
		for table in TABLES:
			in_file = table + '.csv'
			csv_to_sql(table, in_file, out)

def test():
	with open(OUT_FILE, mode='a') as out:
		csv_to_sql('test', 'Renter Info.csv', out)

if __name__ == "__main__":
	convert()
	# test()