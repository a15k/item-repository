import { User } from 'models/user';

describe(User, () => {

  test('bootstrapping', () => {
    const user = new User();
    user.bootstrap({ user: { id: 1, name: 'Test' } });
    expect(user).toMatchObject({
      id: 1, name: 'Test',
    });
    expect(user.isLoggedIn).toBe(false);
  });

});
