
import subprocess
import sys
import os



def run_translate_and_parse(domain, problem):
	# Resolve paths relative to this script's directory so it can be called
	# from any working directory.
	script_dir = os.path.dirname(os.path.abspath(__file__))
	translate_path = script_dir
	translate_stream = os.path.join(translate_path, "translate_stream.py")
	parse_sas = os.path.join(script_dir, "parse_sas.py")

	env = os.environ.copy()
	env["PYTHONPATH"] = translate_path + ":" + env.get("PYTHONPATH", "")

	translate_cmd = ["python3", translate_stream, domain, problem]
	parse_cmd = ["python3", parse_sas]
	try:
		p1 = subprocess.Popen(translate_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
		out1, err1 = p1.communicate()
		if p1.returncode != 0:
			print(f"Error executant translate_stream.py: {err1.decode()}", file=sys.stderr)
			sys.exit(p1.returncode) 
		p2 = subprocess.Popen(parse_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
		out2, err2 = p2.communicate(input=out1)
		
		if p2.returncode != 0:
			print(f"Error executant parse_sas.py: {err2.decode()}", file=sys.stderr)
			sys.exit(p2.returncode)

		print(out2.decode())
		
	except Exception as e:
		print(f"Error executant run_translate_and_parse.py: {e}", file=sys.stderr)
		sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Ús: python run_translate_and_parse_sas.py <domain.pddl> <problem.pddl>", file=sys.stderr)
        sys.exit(1)

    domain = sys.argv[1]
    problem = sys.argv[2]
    run_translate_and_parse(domain, problem)
