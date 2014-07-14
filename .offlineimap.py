import locale
from subprocess import Popen, PIPE

encoding = locale.getdefaultlocale()[1]

def get_password(p):
    (out, err) = Popen(["pass", p], stdout=PIPE).communicate()
    return out.decode(encoding).strip()

