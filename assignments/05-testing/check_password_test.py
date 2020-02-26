import pytest
import System


#test to ensure check_password is working
def test_check_password(grading_system):
    username = "saab"
    password = "Boomr345"
    got = grading_system.check_password(username, password)
    assert got == True


@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem