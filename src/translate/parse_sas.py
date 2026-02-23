import sys
import json

def parse_sas(stream):
	
	variables = {}
	atoms_dict = {}
	mutex_groups = []
	operators_dict = {}
	static_atoms = []

	in_var = False
	in_mutex = False
	in_op = False
	in_static = False

	var_index = None
	var_atoms = []
	group = []
	op_parts = []

	for line in stream:
		line = line.strip()
		if not line:
			continue

		# Bloc variable
		if line.startswith('begin_variable'):
			in_var = True
			var_atoms = []
			continue
		if line.startswith('end_variable'):
			variables[var_index] = var_atoms
			in_var = False
			continue
		if in_var:
			if line.startswith('var'):
				var_index = int(line.replace('var', ''))
			elif line.startswith('Atom'):
				atom = line.replace('Atom ', '').strip()
				var_atoms.append(atom)
				pred, args = atom.split('(')[0], atom.split('(')[1].replace(')', '')
				args_list = [a.strip() for a in args.split(',') if a.strip()]
				atoms_dict.setdefault(pred, []).append(args_list)
			continue

		# Bloc mutex
		if line.startswith('begin_mutex_group'):
			in_mutex = True
			group = []
			continue
		if line.startswith('end_mutex_group'):
			mutex_groups.append(group)
			in_mutex = False
			continue
		if in_mutex and not line.isdigit():
			var_id, val_id = map(int, line.split())
			atom = variables[var_id][val_id]
			atom_fmt = atom.replace('Atom ', '').replace('(', ' ').replace(')', '').replace(',', '')
			atom_fmt = ' '.join(atom_fmt.split())
			group.append(atom_fmt)
			continue

		# Bloc operator
		if line.startswith('begin_operator'):
			in_op = True
			op_parts = []
			continue
		if line.startswith('end_operator'):
			if op_parts and not op_parts[0].isdigit():
				head = op_parts[0]
				args = op_parts[1:]
				operators_dict.setdefault(head, []).append(args)
			in_op = False
			continue
		if in_op:
			parts = line.split()
			if len(parts)>0 and not parts[0].isdigit():
				op_parts = parts
			continue

		# Bloc Static
		if line.startswith('begin_static'):
			in_static = True
			static_atoms = []
			continue
		if line.startswith('end_variable'):
			in_static = False
			continue
		if in_static:
			if line.startswith('Atom'):
				atom = line.replace('Atom ', '').replace("("," ").replace(")"," ").replace(","," ")
				static_atoms.append(' '.join(atom.split()))
			continue

	result = {
		"atoms": atoms_dict,
		"mutex_groups": mutex_groups,
		"operators": operators_dict,
		"static": static_atoms
	}
	
	return json.dumps(result, indent=2)
	#return json.dumps(result)


def parse_sas_path(path):
    if path == '-' or path is None:
        return parse_sas(sys.stdin)
    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
        return parse_sas(f)

if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else '-'
    print(parse_sas_path(path))


