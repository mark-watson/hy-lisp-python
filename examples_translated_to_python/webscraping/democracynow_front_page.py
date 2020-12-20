from get_web_page import get_web_page_from_disk
from bs4 import BeautifulSoup


def get_democracy_now_links():
    test_html = get_web_page_from_disk('democracynow_home_page.html')
    bs = BeautifulSoup(test_html, features='lxml')
    all_anchor_elements = bs.findAll('a')
    return [(e.get('href'), e.get_text()) for e in all_anchor_elements if 
        len(e.get_text()) > 0]


if __name__ == '__main__':
    for [uri, text] in get_democracy_now_links():
        print(uri, ':', text)
    _hy_anon_var_2 = None
else:
    _hy_anon_var_2 = None

