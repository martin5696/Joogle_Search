import pprint
from operator import itemgetter
import crawler


#get page_rank_score

page_rank_score = crawler.return_page_rank()

page_rank_list = []
for key in page_rank_score:
  page_rank_list.append({'doc_id':key,'score':page_rank_score[key]})

sorted_scores = sorted(page_rank_list, key=itemgetter('score'), reverse=True)

pp = pprint.PrettyPrinter(indent=4)
pp.pprint(sorted_scores)
