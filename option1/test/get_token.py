import sys, json

if __name__ == '__main__':
    print(json.loads(sys.argv[1])["token"])
