# Implementing Knowledge Graph Navigator in Hy

Run the program:

One time only, install requirements PyInquirer (for text based menu system: arrow keys up down, spade to select options, enter or return to exit menu with selections):

    pip install -r requirements.txt

(note: PyInquirer is not working for me with newer versions of Python and has not been updated)

and then run the program:

    hy kgn.hy

Enter a list of people, place, organization names when prompted. You then see a list of entities found on DBPedia. Select the entities you want more information on. For example, try entering the following input:

    Bill Gates Microsoft Steve Jobs


