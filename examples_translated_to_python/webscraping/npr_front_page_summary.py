from get_web_page import get_web_page_from_disk
from bs4 import BeautifulSoup


def get_npr_links():
    test_html = get_web_page_from_disk('npr_home_page.html')
    bs = BeautifulSoup(test_html, features='lxml')
    all_anchor_elements = bs.findAll('a')
    filtered_a = [(e.get('href'), e.get_text()) for e in
        all_anchor_elements if len(e.get_text()) > 0]
    return filtered_a


def create_npr_summary():
    links = get_npr_links()
    filtered_links = [text.strip() for [uri, text] in links if len(text.
        strip()) > 40]
    return '\n\n'.join(filtered_links)


print(create_npr_summary()) if __name__ == '__main__' else None

