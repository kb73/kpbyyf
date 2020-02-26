import pytest
import System
import json

def test_add_student(grading_system):
    grading_system.login('goggins', 'augurrox')
    grading_system.usr.add_student('Kevin', 'comp_sci')
    test = False
    for student in grading_system.courses['comp_sci']:
        if student == 'Kevin':
            test = True
    assert test

@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem