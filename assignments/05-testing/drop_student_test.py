import pytest
import System
import json

def test_add_student(grading_system):
    grading_system.login('goggins', 'augurrox')
    grading_system.usr.drop_student('akend3', 'comp_sci')
    test = True
    for student in grading_system.courses['comp_sci']:
        if student == 'akend3':
            test = False
    assert test

@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem