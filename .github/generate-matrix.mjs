import fs from 'fs';
import { execSync } from 'child_process';

const matrix = {
  include: []
};
console.log(`commit: ${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}/commit/${process.env.GITHUB_SHA}`);
console.log(execSync('git log -1').toString().trim())
const folders = fs.readdirSync(".").filter(file => fs.statSync(file).isDirectory());
folders.forEach(folder => {
  const dockerfilePath = `${folder}/Dockerfile`;
  if (!fs.existsSync(dockerfilePath)) return
  try {
    const result = execSync(`git diff --name-only HEAD~1 HEAD ${dockerfilePath}`).toString().trim();
    if (result) {
      matrix.include.push(
        {
          folder: folder
        }
      );
    }
  } catch (error) {
    console.error(`Error checking changes for ${dockerfilePath}:`, error);
  }
});
console.log('='.repeat(80));
console.log('matrix:');
console.log(JSON.stringify(matrix, null, 2));
fs.writeFileSync(process.env.GITHUB_OUTPUT, `matrix=${JSON.stringify(matrix)}`);