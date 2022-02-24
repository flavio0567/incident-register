import { Router } from 'express';
import { CreateUserController } from '../../../../modules/users/infra/http/controllers/CreateUserController';

const routes = Router();

const createUserController = new CreateUserController();

routes.use('/user', createUserController.handle);

export { routes };