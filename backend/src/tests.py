import unittest
from app import app

class FlaskTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_get_unix_time(self):
        response = self.app.get('/clock')
        self.assertEqual(response.status_code, 200)
        unix_time = int(response.get_data(as_text=True))
        self.assertIsInstance(unix_time, int)

if __name__ == '__main__':
    unittest.main()
