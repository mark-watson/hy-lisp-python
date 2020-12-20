from urllib.request import Request, urlopen


def get_raw_data_from_web(aUri, anAgent={'User-Agent': 'HyLangBook/1.0'}):
    req = Request(aUri, headers=anAgent)
    httpResponse = urlopen(req)
    data = httpResponse.read()
    return data


def get_web_page_from_disk(filePath):
    return open(filePath, 'r').read()

