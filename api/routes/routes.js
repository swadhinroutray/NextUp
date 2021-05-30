const router = require('express').Router();
const multer = require('multer');
var storage = multer.memoryStorage();
var upload = multer({ storage: storage });
const hello = require('./hello');
const auth = require('./auth');
const task = require('../controllers/taskController');
const pro = require('../controllers/projectController');
const collaborator = require('../controllers/collaboratorsController');
function isLoggedin(req, res, next) {
	if (req.session) {
		if (req.session.logged_in == true) {
			next();
		} else {
			return res.send({ success: true, data: 'User Not Logged in' });
		}
	} else {
		return res.send({ success: true, data: 'User Not Logged in' });
	}
}

//*Test routes
router.get('/hello', hello.hello);

//* Auth routes
router.post('/register', auth.Register);
router.post('/login', auth.Login);
router.post('/logout', isLoggedin, auth.Logout);

//* Project Controller routes
router.post('/createproject', isLoggedin, pro.createProject);
router.post('/deleteproject', isLoggedin, pro.deleteProject);
router.post('/changedeadline', isLoggedin, pro.editDeadline);
router.post('/changetitle', isLoggedin, pro.changeProjectTitle);

//* Task Controller routes
router.post('/addtask', isLoggedin, task.createTask);
router.post('/edittasktitle', isLoggedin, task.editTaskTitle);
router.post('/edittaskdescription', isLoggedin, task.editTaskDescription);
router.post(
	'/addattachment',
	isLoggedin,
	upload.array('files'),
	task.addAttachmentToTask
);
router.post('/deleteattachment', isLoggedin, task.deleteAttachmentFromTask);
router.post(
	'/initiatestagecompletion',
	isLoggedin,
	task.completeStageInitiation
);
router.post(
	'/finishstagecompletion',
	isLoggedin,
	task.completeStageCheckAndPropagate
);

router.post(
	'/addcollaborator',
	isLoggedin,
	collaborator.addCollaboratorToProject
);
router.post(
	'/removecollaborator',
	isLoggedin,
	collaborator.removeCollaboratorFromProject
);
router.post('/getcollaborators', isLoggedin, collaborator.getCollaborators);
router.post('/getTasks', isLoggedin, task.getTasks);
router.post('/deletetask', isLoggedin, task.deleteTask);

//* GET Routes Implementation
router.get('/getprojects', isLoggedin, pro.getUserProjects);
router.get('/init', auth.init);

module.exports = router;
