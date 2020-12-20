from get_web_page import get_raw_data_from_web
from bs4 import BeautifulSoup


def get_element_data(anElement):
    return {'text': anElement.getText(), 'name': anElement.name, 'class':
        anElement.get('class'), 'href': anElement.get('href')}


def get_page_html_elements(aUri):
    raw_data = get_raw_data_from_web(aUri)
    soup = BeautifulSoup(raw_data, 'lxml')
    title = soup.find_all('title')
    a = soup.find_all('a')
    h1 = soup.find_all('h1')
    h2 = soup.find_all('h2')
    return {'title': title, 'a': a, 'h1': h1, 'h2': h2}


elements = get_page_html_elements('http://markwatson.com')
print(elements['a'])
for ta in elements['a']:
    print(get_element_data(ta))

