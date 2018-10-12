import unittest
from crawler import crawler

class TestCrawlerMethods(unittest.TestCase):
    def setUp(self):
        self.crawler = crawler(None, "urls.txt")
        self.crawler.crawl(depth=1)

    def test_get_inverted_index(self):
        expected_inverted_index = {
            1: set([1, 2]),
            2: set([1]),
            3: set([1]),
            4: set([2])
        }
        self.assertEqual(self.crawler.get_inverted_index(), expected_inverted_index)

    def test_get_resolved_inverted_index(self):
        expected_reolved_inverted_index = {
            'hello': set(['http://localhost:8080/', 'http://localhost:8080/test']),
            'link1': set(['http://localhost:8080/']),
            'word1': set(['http://localhost:8080/']),
            'word2': set(['http://localhost:8080/test'])
        }
        self.assertEqual(self.crawler.get_resolved_inverted_index(), expected_reolved_inverted_index)

if __name__ == '__main__':
    unittest.main()